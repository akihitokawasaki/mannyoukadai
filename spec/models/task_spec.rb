# require 'rails_helper'

# RSpec.describe Task, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  it 'nameが空ならバリデーションが通らない' do
    task = Task.new(name: '', description: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'descriptionが空ならバリデーションが通らない' do
    # ここに内容を記載する
    task = Task.new(name: '失敗テスト', description: '')
    expect(task).not_to be_valid
  end
  it 'nameとdescriptionに内容が記載されていればバリデーションが通る' do
    # ここに内容を記載する
    task = Task.new(name: '成功テスト', description: '成功テスト')
    expect(task).to be_valid
  end
end