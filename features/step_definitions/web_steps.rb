Then /^show me the page$/ do
  save_and_open_page
end

Then /^I should receive a excel file "([^\"]*)"$/ do |filename|
  result = page.response_headers['Content-Type'].should == "application/vnd.ms-excel"
  if result
    result = page.response_headers['Content-Disposition'].should =~ /#{filename}/
  end
  result
end

When /^I click Export$/ do
  click_link "Export"
end