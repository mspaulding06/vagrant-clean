module VagrantPlugins
    module CommandClean
        class Command < Vagrant.plugin('2', :command)
            def self.synopsis
                'destroys all vagrant resources'
            end

            def execute
                opts = OptionParser.new do |o|
                    o.banner = "Usage: vagrant clean"
                end

                argv = parse_options(opts)
                prune = []

                @env.machine_index.each do |entry|
                    env = entry.vagrant_env(entry.vagrantfile_path)
                    machine = env.machine(entry.name.to_sym, entry.provider.to_sym)
                    @env.ui.info("Destroying VM id #{entry.id[0..6]}")
                    action_env = machine.action(:destroy, force_confirm_destroy: true)

                    # Remove machine from index if it was destroyed
                    if action_env.key?(:force_confirm_destroy_result) && action_env[:force_confirm_destroy_result] == true
                        @env.ui.info("Destroyed")
                    else
                        @env.ui.warn("Failed to destroy VM id #{entry.id[0..6]}")
                    end

                    prune << entry
                end

                # Must remove machine from the global index
                prune.each do |entry|
                    e = @env.machine_index.get(entry.id)
                    @env.machine_index.delete(e)
                    @env.machine_index.release(e)
                end

                return 0
            end
        end
    end
end
