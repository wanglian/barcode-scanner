class AppDelegate < PM::Delegate
  def on_load(app, options)
    open ScanScreen
  end
end
