module Vagrant
    module Clean
        class Plugin < Vagrant.plugin('2')
            name 'vagrant-clean'
            description 'clean up all vagrant resources'

            command("clean") do
                require File.expand_path("../clean", __FILE__)
                Command
            end
        end
    end
end
