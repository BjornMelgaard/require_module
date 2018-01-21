module RequireModule
  # Evaluates file content inside Module.new and returns new module
  #
  # ==== Attributes
  #
  # * +fullpath+ - Absolute path to .rb file, .rb extension is optional
  #
  # ==== Options
  #
  # * +:cache+ - Default - true.
  # If false - creates new Module object with unique name.
  # If true - creates new or returns already created Module with name, based on path to file
  #
  # ==== Examples
  #
  #    require_module('/home/user/rubyapp/lib', cache: false) # returns #<Module:0000012312>
  #    require_module('/home/user/rubyapp/lib') # returns :HomeUserRubyappLib
  def require_module(fullpath, cache: true)
    path = fullpath.to_s
    with_ext    = add_ext(path)
    without_ext = rem_ext(path)

    if cache
      constant_name =
        without_ext
        .split(/[^a-zA-Z]/)
        .map(&:capitalize)
        .join
        .to_sym

      begin
        Object.const_get(constant_name)
      rescue NameError
        mod = gen_mod(with_ext)
        Object.const_set(constant_name, mod)
        mod
      end
    else
      gen_mod(with_ext)
    end
  end

  # Similar to "require_module", but path is relative to file, where function is executed
  #
  # ==== Attributes
  #
  # * +path+ - Relative path to .rb file, .rb extension is optional
  #
  # ==== Options
  #
  # * +:cache+ - Default - true.
  # If false - creates new Module object with unique name.
  # If true - creates new or returns already created Module with name, based on path to file
  def require_module_relative(path, **options)
    caller_filepath = caller_locations(1..1).first.absolute_path
    caller_dir = File.dirname(caller_filepath)

    fullpath = File.expand_path(path, caller_dir)

    require_module(fullpath, **options)
  end

  private

  def gen_mod(fullpath)
    content = read_rb(fullpath)

    Module.new.tap do |mod|
      mod.module_eval(content, fullpath, 1)
    end
  end

  def read_rb(fullpath)
    File.read(fullpath)
  rescue Errno::ENOENT
    raise LoadError, "path doesn't exist at #{fullpath}"
  end

  def add_ext(path)
    Pathname.new(path).sub_ext('.rb').to_s
  end

  def rem_ext(path)
    path.sub(/#{File.extname(path)}$/, '')
  end
end

include RequireModule
