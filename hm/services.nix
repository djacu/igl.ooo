{pkgs, ...}: {
  services.ssh-agent.enable = true;
  systemd.user.services.ssh-agent.Service.ExecStartPost = "${pkgs.openssh}/bin/ssh-add ~/.ssh/github";
}
