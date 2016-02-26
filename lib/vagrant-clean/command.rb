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
                    begin
                        env = entry.vagrant_env(@env.home_path)
                    rescue Vagrant::Errors::EnvironmentNonExistentCWD
                        entry = @env.machine_index.get(entry.id)
                        @env.machine_index.delete(entry) if entry
                        next
                    end
                    machine = env.machine(entry.name.to_sym, entry.provider.to_sym)
                    @env.ui.info("==> Destroying vm #{entry.name}:#{entry.id[0..6]}", bold: true)
                    action_env = machine.action(:destroy, force_confirm_destroy: true)

                    # Remove machine from index if it was destroyed
                    if action_env.key?(:force_confirm_destroy_result) && action_env[:force_confirm_destroy_result] == true
                        @env.ui.success("==> Destroyed")
                    else
                        @env.ui.warn("==> Warning: failed to destroy #{entry.name}:#{entry.id[0..6]}")
                    end

                    prune << entry.id
                end

                # Must remove machine from the global index
                prune.each do |id|
                    entry = @env.machine_index.get(id)
                    @env.machine_index.delete(entry) if entry
                end

                return 0
            end
        end
    end
end
