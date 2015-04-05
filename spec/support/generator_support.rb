module GeneratorSupport

  def cleanup_destination_root
    FileUtils.rm_rf destination_root
  end

  def content_for(file_name)
    File.read(file(file_name))
  end

end