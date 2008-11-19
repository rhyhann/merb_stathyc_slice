require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a page exists" do
  Page.all.destroy!
  request(resource(:pages), :method => "POST", 
    :params => { :page => { :id => nil }})
end

describe "resource(:pages)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:pages))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of pages" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a page exists" do
    before(:each) do
      @response = request(resource(:pages))
    end
    
    it "has a list of pages" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Page.all.destroy!
      @response = request(resource(:pages), :method => "POST", 
        :params => { :page => { :id => nil }})
    end
    
    it "redirects to resource(:pages)" do
      @response.should redirect_to(resource(Page.first), :message => {:notice => "page was successfully created"})
    end
    
  end
end

describe "resource(@page)" do 
  describe "a successful DELETE", :given => "a page exists" do
     before(:each) do
       @response = request(resource(Page.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:pages))
     end

   end
end

describe "resource(:pages, :new)" do
  before(:each) do
    @response = request(resource(:pages, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@page, :edit)", :given => "a page exists" do
  before(:each) do
    @response = request(resource(Page.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@page)", :given => "a page exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Page.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @page = Page.first
      @response = request(resource(@page), :method => "PUT", 
        :params => { :page => {:id => @page.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@page))
    end
  end
  
end

