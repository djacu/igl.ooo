{
  programs.git = {
    enable = true;
    userName = "Daniel Baker";
    userEmail = "daniel.n.baker@gmail.com";
    extraConfig = {
      core = {
        editor = "vim";
      };
      status = {
        short = "true";
        branch = "true";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
