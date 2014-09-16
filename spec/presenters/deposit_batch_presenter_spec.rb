require "spec_helper"
include ActionView::Helpers::NumberHelper

describe DepositBatchPresenter do

  let!(:employee) { FactoryGirl.create(:employee) }

  let!(:deposit_batch) { FactoryGirl.create(:deposit_batch,
                                            employee: employee) }
  let!(:payment) { FactoryGirl.create(:payment,
                                      deposit_batch: deposit_batch)}
  let(:presenter) { DepositBatchPresenter.new(deposit_batch) }

  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of DepositBatchPresenter
    end
  end

  describe '#model' do
    it 'should return the original object' do
      expect(presenter.model).to be_an_instance_of DepositBatch
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

  describe '#payment_count' do
    it 'should return the correct count' do
      expect(presenter.payment_count).to eq 1
    end
  end

  describe '#payment_total' do
    it 'should return the correct total' do
      expect(presenter.payment_total).to eq number_to_currency(payment.amount)
    end
  end

  describe '#approved_by' do
    it 'should return the correct name' do
      expect(presenter.approved_by).to eq employee.full_name
    end
  end

  describe '#formatted_date' do
    it 'should return the formatted date' do
      expect(presenter.formatted_date).to eq I18n.l(deposit_batch.date)
    end
  end
  describe '#formatted_created_at' do
    it 'should return the formatted timestamp' do
      expect(presenter.formatted_created_at).to eq \
        I18n.l(deposit_batch.created_at, format: :long)
    end
  end

  describe '#formatted_updated_at' do
    it 'should return the formatted timestamp' do
      expect(presenter.formatted_updated_at).to eq \
        I18n.l(deposit_batch.updated_at, format: :long)
    end
  end
end
