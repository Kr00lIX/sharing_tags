module GeneratorSupport
  def create_file(file_path, content = '')
    full_file_path = File.expand_path(file_path, destination_root)
    FileUtils.mkdir_p File.dirname(full_file_path)
    File.write full_file_path, content
  end

  def touch_file(file_path)
    full_file_path = File.expand_path(file_path, destination_root)

    FileUtils.mkdir_p File.dirname(full_file_path)
    FileUtils.touch full_file_path
  end

  def cleanup_destination_root
    FileUtils.rm_rf destination_root
  end

  def content_for(file_name)
    File.read(file(file_name))
  end
end
