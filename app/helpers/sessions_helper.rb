module SessionsHelper
  # ログインする
  # サブユーザーならグループに入れる
  def log_in(user)
    session[:user_id] = user.id
    if !user.admin
      group_in(user.groups.first)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def admin?
    current_user.admin
  end

  # ログイン情報を保存する
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # ログイン情報を削除する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    session.delete(:group_id)
  end

  # 自分が所属するグループか？
  def current_user_belongs_to?(group)
    current_user.groups.include?(group)
  end

  # グループ情報を保存する
  def group_in(group)
    if current_user_belongs_to?(group)
      session[:group_id] = group.id
    else
      session.delete(:group_id)
    end
  end
end
