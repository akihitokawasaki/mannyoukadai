FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'Factoryで作ったデフォルトのタイトル１' }
    description { 'Factoryで作ったデフォルトのコンテント１' } 
    deadline {'2000-1-1'}
    status {0}
    priority {0}
  end

  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル２' }
    description { 'Factoryで作ったデフォルトのコンテント２' }
    deadline {'2100-1-1'}
    status {1}
    priority {1}
  end
end