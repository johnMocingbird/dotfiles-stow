Pry.config.editor = "nvim"
Pry.config.hooks.add_hook(:when_started, :notify_tmux) do |out, _, _|
│ window_name = `tmux display-message -p '#W'`.strip
│ `tmux display-message 'PRY session started in window: #{window_name}'`
end
