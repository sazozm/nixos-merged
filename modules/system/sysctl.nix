{ ... }:

{
  flake.nixosModules.sysctl = {
    boot.kernel.sysctl = {

      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 10;
      "vm.max_map_count" = 262144;
      "kernel.sched_min_granularity_ns" = 10000000;
      "kernel.sched_wakeup_granularity_ns" = 15000000;
      "kernel.sched_autogroup_enabled" = 1;
      "kernel.numa_balancing" = 0;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq";
      "net.core.rmem_max" = 10485760;
      "net.core.wmem_max" = 10485760;
      "net.ipv4.tcp_rmem" = "4096 87380 10485760";
      "net.ipv4.tcp_wmem" = "4096 65536 10485760";
      "net.core.somaxconn" = 65535;
      "net.ipv4.tcp_fastopen" = 3;
      "fs.inotify.max_user_watches" = 524288;
      "fs.inotify.max_user_instances" = 512;
    };
  };
}
