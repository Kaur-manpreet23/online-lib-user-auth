class User < ApplicationRecord
  has_secure_password
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
  #belongs_to :logs, class_name: 'Log'

  def history
    Book.joins("INNER JOIN manage_borrows ON books.id = manage_borrows.bid")
        .where(manage_borrows: {uid: id})
        .select("books.id,books.title,books.author,books.publication_date,books.genre,
        manage_borrows.id as borrow_id,manage_borrows.uid,manage_borrows.issue_date,manage_borrows.return_date")
  end

  def del_user(email,password)
      user = User.find_by(email: email).try(:authenticate, password)
      if self.role == 'admin'
        if user.role == 'member' || user.role == 'librarian'
          user.destroy
          return{message: "User deleted successfully"}
        else
          return {message: "Deletion Prohibited"}
        end
      elsif self.role == 'librarian'
        if user.role == 'member'
          user.destroy
          return {message: "User deleted successfully"}
        else
          return {message: "Deletion Prohibited"}
        end
      else
        return { message: "Action Prohibited" }
      end
  end

  def adding_user(email,password,password_confirmation,role)
    if self.role == 'admin'
      if role == 'member' || role == 'librarian'
        User.create(email: email, password: password, password_confirmation: password_confirmation, role: role)
      else
        return {message: "Addition Prohibited"}
      end
    elsif self.role == 'librarian'
      if role == 'member'
        User.create(email: email, password: password, password_confirmation: password_confirmation, role: role)
      else
        return {message: "Addition Prohibited"}
      end
    else
      return {message: "Action Prohibited"}
    end
  end
end
