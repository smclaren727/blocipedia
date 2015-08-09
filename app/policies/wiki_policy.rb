class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.private != true || (user.present? && ((user.role == 'admin') || record.user == user || record.users.include?(user)))  
  end

  def update?
    show? 
  end

  def edit?
    show? 
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # scope = Wiki
    def resolve
    
      # if the user is an admin, show them all the wikis
      if user.role == 'admin'
        scope.all
      
      elsif user.role == 'premium'
      
        # if the user is premium, only show them public wikis, 
        # or that private wikis they created, 
        # or private wikis they are a collaborator on
      
        scope.eager_load(:collaborators).where("wikis.private = ? OR wikis.user_id = ? OR collaborators.user_id = ?", user.id, false, user.id)
      
      else # this is the lowly standard user
      
        # only show standard users public wikis and private wikis they are a collaborator on
      
        scope.eager_load(:collaborators).where("wikis.private = ? OR collaborators.user_id = ?", false, user.id)
      end
    end
  end
end