module VagrantPlugins
    module CommandInit
        class Command < Vagrant.plugin('2', :command)
            def self.synopsis
                'destroys all vagrant resources'
            end

            def execute
                @env.machine_index.each do |machine|
                    @logger.notice("Destroying VM #{machine.name}")
                    machine.action(:destroy, force_confirm_destroy: true)
                end
            end
        end
    end
end
