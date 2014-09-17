class AddIssueKnowledgeToSupporters < ActiveRecord::Migration
  def change
    add_column :supporters, :issue_knowledge, :integer, default: 0
  end
end
