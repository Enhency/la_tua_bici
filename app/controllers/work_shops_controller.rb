# encoding : utf-8
class WorkShopsController < BeautifulController

  before_action :load_work_shop, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields]["work_shop"] ||= (WorkShop.columns.map(&:name) - ["id"])[0..4]
    do_select_fields("work_shop")
    do_sort_and_paginate("work_shop")
    
    @q = WorkShop.search(
      params[:q]
    )

    @work_shop_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @work_shop_scope_for_scope = @work_shop_scope.dup
    
    unless params[:scope].blank?
      @work_shop_scope = @work_shop_scope.send(params[:scope])
    end
    
    @work_shops = @work_shop_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @work_shop_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << WorkShop.attribute_names
          @work_shop_scope.to_a.each{ |o|
            csv << WorkShop.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
      format.xml{ 
        render :xml => @work_shop_scope.to_a
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(WorkShop,@work_shop_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @work_shop }
    end
  end

  def new
    @work_shop = WorkShop.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @work_shop }
    end
  end

  def edit
    
  end

  def create
    @work_shop = WorkShop.create(params_for_model)

    respond_to do |format|
      if @work_shop.save
        format.html {
          if params[:mass_inserting] then
            redirect_to work_shops_path(:mass_inserting => true)
          else
            redirect_to work_shop_path(@work_shop), :flash => { :notice => t(:create_success, :model => "work_shop") }
          end
        }
        format.json { render :json => @work_shop, :status => :created, :location => @work_shop }
      else
        format.html {
          if params[:mass_inserting] then
            redirect_to work_shops_path(:mass_inserting => true), :flash => { :error => t(:error, "Error") }
          else
            render :action => "new"
          end
        }
        format.json { render :json => @work_shop.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @work_shop.update_attributes(params_for_model)
        format.html { redirect_to work_shop_path(@work_shop), :flash => { :notice => t(:update_success, :model => "work_shop") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @work_shop.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @work_shop.destroy

    respond_to do |format|
      format.html { redirect_to work_shops_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @work_shops = []    
    
    WorkShop.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:work_shop)

        @work_shops = WorkShop.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @work_shops = WorkShop.find(params[:ids].to_a)
      end

      @work_shops.each{ |work_shop|
        if not WorkShop.columns_hash[attr_or_method].nil? and
               WorkShop.columns_hash[attr_or_method].type == :boolean then
         work_shop.update_attribute(attr_or_method, boolean(value))
         work_shop.save
        else
          case attr_or_method
          # Set here your own batch processing
          # work_shop.save
          when "destroy" then
            work_shop.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = WorkShop
    foreignkey = :work_shop_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_work_shop
    @work_shop = WorkShop.find(params[:id])
  end

  def params_for_model
    params.require(:work_shop).permit(WorkShop.permitted_attributes)
  end
end

