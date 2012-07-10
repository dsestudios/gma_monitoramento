require "yaml"

conf = Configuration.file

if not conf
  Configuration.destroy_all
else
  conf_db = Configuration.all
  conf_db.each do |c|
    if not conf.has_key?(c.nickname)
      c.destroy
    end
  end

  conf.each do |k, v|
    if not Configuration.exist?(k)
      Configuration.create!(:nickname => k, :value => v["default"])
    end
  end
end