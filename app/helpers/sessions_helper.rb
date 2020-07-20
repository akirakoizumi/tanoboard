module SessionsHelper
  # ログインする
  # デフォルトグループidが設定されていたらsessionを登録する
  def log_in(user)
    session[:user_id] = user.id
    if user.default_group_id
      group_in(Group.find(user.default_group_id))
    elsif user.groups.present?
      group_in(Group.find(user.groups.first.id))
      if current_user.default_group_id.nil?
        current_user.default_group_id = group
      end
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

  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # 自分が所属するグループか？
  # def current_user_belongs_to?(group)
  #  current_user.groups.include?(group)
  # end

  # グループセッション情報を保存する
  def group_in(group)
    if current_user.belongs_to?(group)
      session[:group_id] = group.id
      if current_user.default_group_id.nil?
        current_user.default_group_id = group.id
      end
    else
      session.delete(:group_id)
    end
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
