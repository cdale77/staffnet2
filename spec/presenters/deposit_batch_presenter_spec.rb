require "spec_helper"

describe DepositBatchPresenter do

  let(:deposit_batch) { FactoryGirl.create(:deposit_batch) }
  let(:presenter) { DepositBatchPresenter.new(deposit_batch) }

  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of DepositBatchPresenter
    end
  end

  describe '#approved' do
    it 'should return true if the batch is approved' do
      expect(presenter.approved).to eq deposit_batch.approved
    end
  end

  describe '#not_approved' do
    it 'should return true if the batch is not approved' do
      expect(presenter.not_approved).to eq !deposit_batch.approved
    end
  end


  describe '#human_name' do
    it 'should return the humanized type name' do
      expect(presenter.human_name).to eq deposit_batch.batch_type.humanize
    end
  end

  describe '#date' do
    it 'should return a localized date' do
      expect(presenter.date).to eq I18n.l(deposit_batch.date)
    end
  end
end