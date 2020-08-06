class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  attachment :profile_image, destroy: false

  # ====================自分がフォローしているユーザーとの関連 ===================================
  # フォローする側からフォローするユーザーの情報を集める。そのための「active_relationships」という疑似モデルを定義。親子関係
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follow_user_id
  # 中間テーブルを介してフォローユーザーの情報を集めることを「followings」と定義 N対Nを＝＞N対1に変えている。親の子の子の関係を直接つないでいる
  has_many :followings, through: :active_relationships, source: :follower_user
  # ========================================================================================

# 親子関係の説明
# user.followings
# parent child grandchild
# parent.children

# child.parent
# grandchild.child.parent
# has_many grandchildren, through: :child

  # ====================自分がフォローされるユーザーとの関連 ===================================
  # フォローされる側からフォローされるユーザーの情報を集める。そのための「passive_relationships」という疑似モデルを定義。
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_user_id
  # 中間テーブルを介してフォローされるユーザーを集めることを「followers」と定義
  has_many :followers, through: :passive_relationships, source: :follow_user
  # =======================================================================================

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(follow_user_id: user.id).present?
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
