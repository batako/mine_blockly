shared_examples "has status code 200" do |body: false|
  it "has status code 200" do
    subject

    expect(response.status).to eq 200
  end
end
