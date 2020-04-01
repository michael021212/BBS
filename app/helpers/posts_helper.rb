module PostsHelper
  def puts_search_word_if_exists
    if params[:q] == nil || params[:q]["title_or_comments_body_cont"].empty?
      '全スレッド'
    else
      "\"#{params[:q]["title_or_comments_body_cont"]}\" の検索結果"
    end
  end
end
