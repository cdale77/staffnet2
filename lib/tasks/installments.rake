namespace :installments do
  desc "Process installment payments"

  task process_payments: :environment do
    puts "What is the batch id?"
    id = STDIN.gets.chomp
    InstallmentPaymentsJob.enqueue(id.to_i)
  end
end
