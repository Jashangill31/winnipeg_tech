def index
    @products = Product.all
  
    if params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == "recent"
      @products = @products.where("updated_at >= ?", 3.days.ago)
                            .where("created_at < ?", 3.days.ago) # exclude newly created
    end
  
    @products = @products.page(params[:page]).per(12)
  end
  