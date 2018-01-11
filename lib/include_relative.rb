module IncludeRelative
  def include_relative(path)
    caller_filepath = caller_locations(1..1).first.absolute_path
    caller_dir = File.dirname(caller_filepath)

    # read content
    fullpath = File.expand_path(path, caller_dir)

    begin
      with_extension = Pathname.new(fullpath).sub_ext('.rb').realpath
    rescue Errno::ENOENT
      raise LoadError, "path doesn't exist at #{with_extension}"
    end

    content = File.read(with_extension)

    # include uniq module
    mod = Module.new
    mod.module_eval(content)
    extend mod
  end
end

include IncludeRelative
