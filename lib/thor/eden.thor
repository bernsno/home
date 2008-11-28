# Thanks Blank!
# http://github.com/giraffesoft/blank/tree/master
class Eden < Thor
  EDEN_REPO = 'git://github.com/matthooks/eden.git'
  
  desc "let_there_be_light NAME REPO [BRANCH]", "Create a new Eden app, from branch BRANCH (defaults to master), in directory NAME, push it to REPO."
  def let_there_be_light(name, repo, branch=nil)
    @name = name
    @repo = repo
    
    raise Thor::Error unless !repo?
    
    puts "- On the first day God made Eden..."
    # TODO: puts around these for output?
    `git clone -o eden #{EDEN_REPO} #{name}`
    `cd #{name}; git submodule init`
    `cd #{name}; git submodule update`
    `cd #{name}; git checkout eden/#{branch}` unless branch.nil? || branch == ''
    
    puts "\n- On the second day God made #{name}..."
    puts rake('eden:set_project_origin', :repo => repo)
    
    puts "\n- On the third day God made this secret key..."
    rake "eden:set_session_variables", :name => name
    rake "eden:ignore_files"
    commit "Add generated session configuration."
    
    # TODO: Rake task to create proper database.yml and application.yml files
    
    # puts "\n- On the fourth day God made a database..."
    # rake "db:schema:load"
    # rake "db:test:prepare"
    
    # puts "\n- On the fifth day God made a man..."
    # puts rake "eden:create_default_admin_user"
    
    puts "\n- But then he needed to rest so he left some TODOs..."
    puts rake(:notes)
  end
  
  protected
    def in_project_dir(cmd)
      `cd #{@name}; #{cmd}`
    end
  
    def rake(task, opts={})
      args = opts.map { |name, value| name.to_s.upcase + "=" + value }.join(' ')
      in_project_dir "rake #{task} #{args}"
    end
    
    def commit(msg)
      in_project_dir "git add ."
      in_project_dir "git commit -m\"#{msg} (Eden)\""
    end

    def repo?
      !@repo.nil? && !@repo == ''
    end
end