require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    @task = FactoryBot.create(:task, name: 'task')
  end
  # background do
  #   # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
  #   FactoryBot.create(:task)
  #   FactoryBot.create(:second_task)
  # end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        # beforeに必要なタスクデータが作成されるので、ここでテストデータ作成処理を書く必要がない
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        new_task = FactoryBot.create(:task, name: 'new_task')
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
      end
    end
  end
    
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        # task = FactoryBot.create(:task, name: 'task')
        # new_task_pathにvisitする（タスク登録ページに遷移する）
      # 1.ここにnew_task_pathにvisitする処理を書く
        visit new_task_path
        fill_in 'task_name', with: 'テストコード' 
        fill_in 'task_description', with: 'テストコード詳細'
        select('未着手')
        select('高')
        click_on '登録する'
        expect(page).to have_content 'テストコード'
      end
    end
  end  
  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         task = FactoryBot.create(:task, name: 'テストコード')
         visit tasks_path
         click_on 'Show', match: :first
         expect(page).to have_content 'テストコード'
       end 
     end
  end
  describe 'タスク一覧画面' do
    context '検索をした場合' do
      before do
        FactoryBot.create(:task, name: "task")
        FactoryBot.create(:second_task, name: "sample")
      end
      it "タイトルで検索できる" do
        visit tasks_path
        fill_in 'Name', with: "sample"
        select("着手中")
        click_on "検索"
        expect(page).to have_content "Factoryで作ったデフォルトのコンテント２"
      end
    end
  end
end