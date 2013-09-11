# encoding: utf-8
require "meat_sauce/version"
require "meat_sauce/cli"

module MeatSauce
  # 一旦なしよ
  def self.load_thorfiles(dir)
    Dir.chdir(dir) do
      thor_files = Dir.glob('**/*.thor').delete_if { |x| not File.file?(x) }
      thor_files.each do |f|
        Thor::Util.load_thorfile(f)
      end
    end
  end

#  MeatSauce.load_thorfiles('lib/meat_sauce')
end
