 class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

	def show?
		record.private == false || ((record.private == true && record.user == user) || user.admin? if user) || record.users.include?(user)
	end

 end
