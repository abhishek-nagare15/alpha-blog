require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
    @admin = User.create(
      username: "admin",
      email: "admin@example.com",
      password: "password",
      admin: true
    )
    @user = User.create(
      username: "user",
      email: "user@example.com",
      password: "password",
      admin: false
    )
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new as admin" do
    sign_in_as(@admin)

    get new_category_url

    assert_response :success
  end

  test "should not get new as non-admin" do
    sign_in_as(@user)

    get new_category_url

    assert_redirected_to categories_url
  end

  test "should create category as admin" do
    sign_in_as(@admin)

    assert_difference("Category.count", 1) do
      post categories_url, params: { category: { name: "Travel" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should not create category as non-admin" do
    sign_in_as(@user)

    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "Travel" } }
    end

    assert_redirected_to categories_url
  end

  test "should show category" do
    get category_url(@category)

    assert_response :success
  end
end