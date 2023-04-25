#include <storages/mongo/congestion_control/sensor.hpp>

#include <storages/mongo/pool_impl.hpp>

USERVER_NAMESPACE_BEGIN

namespace storages::mongo::cc {

namespace {

void SumStats(const stats::PoolStatistics& stats, size_t& total,
              size_t& network_errors) {
  total = 0;
  network_errors = 0;

  for (const auto& [_, coll_stats] : stats.collections) {
    for (const auto& [_, op_stats] : coll_stats->items) {
      total += op_stats->total_queries.load();
      network_errors += op_stats->network_errors.load();
    }
  }
}

}  // namespace

Sensor::Sensor(impl::PoolImpl& pool) : pool_(pool) {}

Sensor::Data Sensor::GetCurrent() {
  const auto& stats = pool_.GetStatistics();
  size_t total{};
  size_t network_errors{};
  SumStats(stats, total, network_errors);

  auto new_timeouts = network_errors;
  auto diff_timeouts = new_timeouts - last_timeouted_queries;
  last_timeouted_queries = new_timeouts;

  auto new_total = total;
  auto diff_total = new_total - last_total_queries;
  last_total_queries = new_total;
  if (diff_total == 0) diff_total = 1;

  auto timeout_rate = static_cast<double>(diff_timeouts) / diff_total;
  LOG_DEBUG() << "timeout rate = " << timeout_rate;

  auto current_load = pool_.InUseApprox();
  return {diff_total, diff_timeouts, current_load};
}

}  // namespace storages::mongo::cc

USERVER_NAMESPACE_END
