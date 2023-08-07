FactoryBot.define do
  factory :course do
    title { 'Sample Title' }
    # description { 'Sample Description' }
    description { "A" * 100 } # Minimum of 100 characters
    # documents { [Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec', 'fixtures', 'document.pdf')))] }
    # document {'anyfile.txt'}
    # file ActionDispatch::Http::UploadedFile.new(:tempfile => "#{Rails.root}/spec/fixtures/anyfile.txt", :document => "anyfile.txt")
    # documents = fixture_file_upload('spec/fixtures/test_file.pdf', 'application/pdf')
    documents { 'fixture_file_upload { "spec/fixtures/test_file.pdf" }' }

  end
end


