module VagrantPlugins
    module CommandClean
        class Command < Vagrant.plugin('2', :command)
            def self.synopsis
                'destroys all vagrant resources'
            end

            def execute
=begin
                opts = OptionParser.new do |o|
                    o.banner = "Usage: vagrant clean"
                end

                argv = parse_options(opts)

                @env.machine_index.each do |machine|
                    @logger.notice("Destroying VM #{machine.name}")
                    machine.action(:destroy, force_confirm_destroy: true)
                end
=end
                @logger.info("Hello from clean plugin")

                return 0
            end
        end
    end
end
