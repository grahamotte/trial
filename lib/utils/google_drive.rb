def gd_session
  @gd_session ||= begin
    write('config.json', CREDS.google.drive_config_json)
    session = GoogleDrive::Session.from_config(results_path("config.json"))
    delete('config.json')
    session
  end
end
