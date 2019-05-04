class BlogsController < ApplicationController
  
  #ユーザーがサインインしているかを確認する
  #サインインしていない場合は、index画面にリダイレクト
  before_action :move_to_index, except: [:index]

  def index
    @blogs = Blog.includes(:user).order("created_at DESC")
  end

  def new
    # newのビュー画面でform_forを使用するためにインスタンス変数をここに宣言
    @blog = Blog.new
  end

  def create
    Blog.create(blog_params)
    # 投稿完了後はindexアクションを実行し、index画面にリダイレクトする。
    redirect_to action: :index
  end

  def edit
    # binding.pry
    @blog = Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])
    # ブログのidと現在のuseridチェック
    if blog.user_id == current_user.id
      blog_params.delete(:user_id)
      blog.update(blog_params)

    # 投稿完了後はindexアクションを実行し、index画面にリダイレクトする。
    end
    redirect_to action: :index
  end

  # ブログの削除
  def destroy
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.destroy
    end
    # 最新の情報を表示するためにindexアクションにリダイレクト
    redirect_to action: :index
  end

  private 
  def blog_params
    params.require(:blog).permit(:title, :content).merge(user_id: current_user.id)
  end

  #サインインしていない場合、インデックスページに遷移する
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
