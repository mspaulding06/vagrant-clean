module VagrantPlugins
    module CommandClean
        class Plugin < Vagrant.plugin('2')
            name 'vagrant-clean'
            description 'clean up all vagrant resources'

            command("clean") do
                require_relative 'command'
                Command
            end
        end
    end
end
