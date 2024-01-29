_: {
  zramSwap = {
    enable = true;
    memoryMax = 17179869184;
  };

  boot.kernel.sysctl = {
    "vm.page-cluster" = 0;
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
  };
}
