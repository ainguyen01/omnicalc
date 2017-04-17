class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================




    word_array=@text.split
    number_words= word_array.length
    @word_count = number_words

    @character_count_with_spaces = @text.length

    text_wo_spaces = @text.gsub(" ", "")
    text_wo_linefeed= text_wo_spaces.gsub("\n","")
    text_wo_cr = text_wo_linefeed.gsub("\r","")
    text_wo_tabs = text_wo_cr.gsub("\t","")

    @character_count_without_spaces = text_wo_tabs.length

    special_count=@special_word.downcase
    text_downcase=@text.downcase.gsub(/[^a-z0-9\s]/i, "")
    text_downcase_array=text_downcase.split
    special_word_count= text_downcase_array.count(special_count)

    @occurrences = special_word_count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    monthly_rate=@apr/12/100
    loan_term=@years*12
    rate_factor=(1+monthly_rate)**loan_term
    monthly_amount=((monthly_rate*@principal*rate_factor)/(rate_factor-1))

    @monthly_payment = monthly_amount

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================
    time_diff=@ending-@starting
    time_diff_min= time_diff/60
    time_diff_hr=time_diff_min/60
    time_diff_day=time_diff_hr/24
    time_diff_week= time_diff_day/7
    time_diff_year=time_diff_week/52
    @seconds = time_diff
    @minutes = time_diff_min
    @hours = time_diff_hr
    @days = time_diff_day
    @weeks = time_diff_week
    @years = time_diff_year

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    number_array=@numbers
    number_count=number_array.count
    number_sum=number_array.sum
    number_average= number_sum/number_count

    sample_square_diff= []
    number_array.each do |var|
      diff = var - number_average
      square_diff= diff**2

      sample_square_diff.push(square_diff)
    end

    sum_square_diff=sample_square_diff.sum
    var=sum_square_diff/(number_count)

    sdev=Math.sqrt(var)

    sorted_array = number_array.sort

    od_mid = (number_count-1)/2
    median_odd = sorted_array[od_mid]
    ev_mid1= (number_count)/2
    ev_mid2=(ev_mid1)-1
    median_even= (sorted_array[ev_mid1]+sorted_array[ev_mid2])/2


    if number_count.odd?
      median_number = median_odd
    else
      median_number= median_even
    end

    number_freq = number_array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    mode_number=number_array.max_by { |v| number_freq[v] }


    @sorted_numbers = sorted_array

    @count = number_array.count

    @minimum = number_array.min

    @maximum = number_array.max

    @range = number_array.max - number_array.min

    @sum = number_sum

    @mean = number_average

    @mode = mode_number

    @median = median_number

    @variance = var

    @standard_deviation = sdev



    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
