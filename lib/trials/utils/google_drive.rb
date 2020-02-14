def gd_session
  @gd_session ||= begin
    write_tmp('config.json', secrets.google.drive_config_json)
    session = GoogleDrive::Session.from_config(tmp_path("config.json"))
    delete('config.json')
    session
  end
end
