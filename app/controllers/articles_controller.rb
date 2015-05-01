class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new' # renderしているので入力済みの内容を引き継ぐ
    end
    #createアクションも、saveの結果がfalseの場合には、redirect_toではなく、newテンプレートに対するrenderを実行するように変更されました。
    #ここでrenderメソッドを使用する理由は、ビューのnewテンプレートが描画されたときに、@articleオブジェクトがビューのnewテンプレートに返されるようにするためです。
    #renderによる描画は、フォームの送信時と同じリクエスト内で行われます。対照的に、redirect_toはサーバーに別途リクエストを発行するようブラウザに対して指示するので、やりとりが1往復増えます。
  end

  def show
    @article = Article.find(params[:id])
  end

  private
    def article_params
      params.require(:article).permit(:title, :text) # 暗黙的にreturn
    end

end
