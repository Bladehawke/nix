# git-credentials
{ ... }: {
  hjem.users.xf = {
    enable = true;
    files = {
      ".git-credentials".text = ''http://xf:Elliott_9@192.168.68.182%3a3002'';
    };
  };
}
