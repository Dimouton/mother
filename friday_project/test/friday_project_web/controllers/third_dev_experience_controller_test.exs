defmodule FridayProjectWeb.ThirdDevExperienceControllerTest do
  use FridayProjectWeb.ConnCase

  import FridayProject.FridaysFixtures

  @create_attrs %{name: "some name", description: "some description", nb_thing: 42}
  @update_attrs %{
    name: "some updated name",
    description: "some updated description",
    nb_thing: 43
  }
  @invalid_attrs %{name: nil, description: nil, nb_thing: nil}

  describe "index" do
    test "lists all third_dev_experiences", %{conn: conn} do
      conn = get(conn, ~p"/third_dev_experiences")
      assert html_response(conn, 200) =~ "Listing Third dev experiences"
    end
  end

  describe "new third_dev_experience" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/third_dev_experiences/new")
      assert html_response(conn, 200) =~ "New Third dev experience"
    end
  end

  describe "create third_dev_experience" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/third_dev_experiences", third_dev_experience: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/third_dev_experiences/#{id}"

      conn = get(conn, ~p"/third_dev_experiences/#{id}")
      assert html_response(conn, 200) =~ "Third dev experience #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/third_dev_experiences", third_dev_experience: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Third dev experience"
    end
  end

  describe "edit third_dev_experience" do
    setup [:create_third_dev_experience]

    test "renders form for editing chosen third_dev_experience", %{
      conn: conn,
      third_dev_experience: third_dev_experience
    } do
      conn = get(conn, ~p"/third_dev_experiences/#{third_dev_experience}/edit")
      assert html_response(conn, 200) =~ "Edit Third dev experience"
    end
  end

  describe "update third_dev_experience" do
    setup [:create_third_dev_experience]

    test "redirects when data is valid", %{conn: conn, third_dev_experience: third_dev_experience} do
      conn =
        put(conn, ~p"/third_dev_experiences/#{third_dev_experience}",
          third_dev_experience: @update_attrs
        )

      assert redirected_to(conn) == ~p"/third_dev_experiences/#{third_dev_experience}"

      conn = get(conn, ~p"/third_dev_experiences/#{third_dev_experience}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      third_dev_experience: third_dev_experience
    } do
      conn =
        put(conn, ~p"/third_dev_experiences/#{third_dev_experience}",
          third_dev_experience: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Third dev experience"
    end
  end

  describe "delete third_dev_experience" do
    setup [:create_third_dev_experience]

    test "deletes chosen third_dev_experience", %{
      conn: conn,
      third_dev_experience: third_dev_experience
    } do
      conn = delete(conn, ~p"/third_dev_experiences/#{third_dev_experience}")
      assert redirected_to(conn) == ~p"/third_dev_experiences"

      assert_error_sent 404, fn ->
        get(conn, ~p"/third_dev_experiences/#{third_dev_experience}")
      end
    end
  end

  defp create_third_dev_experience(_) do
    third_dev_experience = third_dev_experience_fixture()
    %{third_dev_experience: third_dev_experience}
  end
end
