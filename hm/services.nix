{pkgs, ...}: {
  services.ssh-agent.enable = true;

  # This didn't work.
  # Nov 10 22:59:35 iglooo ssh-add[1323]: Could not open a connection to your authentication agent.
  # systemd.user.services.ssh-agent.Service.ExecStartPost = "${pkgs.openssh}/bin/ssh-add home/bakerdn/.ssh/github";
}
