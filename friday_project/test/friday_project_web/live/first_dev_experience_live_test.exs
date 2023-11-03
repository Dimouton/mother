defmodule FridayProjectWeb.FirstDevExperienceLiveTest do
  use FridayProjectWeb.ConnCase

  import Phoenix.LiveViewTest
  import FridayProject.FridaysFixtures

  @create_attrs %{name: "some name", description: "some description", nb_thing: 42}
  @update_attrs %{
    name: "some updated name",
    description: "some updated description",
    nb_thing: 43
  }
  @invalid_attrs %{name: nil, description: nil, nb_thing: nil}

  defp create_first_dev_experience(_) do
    first_dev_experience = first_dev_experience_fixture()
    %{first_dev_experience: first_dev_experience}
  end

  describe "Index" do
    setup [:create_first_dev_experience]

    test "lists all first_dev_experiences", %{
      conn: conn,
      first_dev_experience: first_dev_experience
    } do
      {:ok, _index_live, html} = live(conn, ~p"/first_dev_experiences")

      assert html =~ "Listing First dev experiences"
      assert html =~ first_dev_experience.name
    end

    test "saves new first_dev_experience", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/first_dev_experiences")

      assert index_live |> element("a", "New First dev experience") |> render_click() =~
               "New First dev experience"

      assert_patch(index_live, ~p"/first_dev_experiences/new")

      assert index_live
             |> form("#first_dev_experience-form", first_dev_experience: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#first_dev_experience-form", first_dev_experience: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/first_dev_experiences")

      html = render(index_live)
      assert html =~ "First dev experience created successfully"
      assert html =~ "some name"
    end

    test "updates first_dev_experience in listing", %{
      conn: conn,
      first_dev_experience: first_dev_experience
    } do
      {:ok, index_live, _html} = live(conn, ~p"/first_dev_experiences")

      assert index_live
             |> element("#first_dev_experiences-#{first_dev_experience.id} a", "Edit")
             |> render_click() =~
               "Edit First dev experience"

      assert_patch(index_live, ~p"/first_dev_experiences/#{first_dev_experience}/edit")

      assert index_live
             |> form("#first_dev_experience-form", first_dev_experience: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#first_dev_experience-form", first_dev_experience: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/first_dev_experiences")

      html = render(index_live)
      assert html =~ "First dev experience updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes first_dev_experience in listing", %{
      conn: conn,
      first_dev_experience: first_dev_experience
    } do
      {:ok, index_live, _html} = live(conn, ~p"/first_dev_experiences")

      assert index_live
             |> element("#first_dev_experiences-#{first_dev_experience.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#first_dev_experiences-#{first_dev_experience.id}")
    end
  end

  describe "Show" do
    setup [:create_first_dev_experience]

    test "displays first_dev_experience", %{
      conn: conn,
      first_dev_experience: first_dev_experience
    } do
      {:ok, _show_live, html} = live(conn, ~p"/first_dev_experiences/#{first_dev_experience}")

      assert html =~ "Show First dev experience"
      assert html =~ first_dev_experience.name
    end

    test "updates first_dev_experience within modal", %{
      conn: conn,
      first_dev_experience: first_dev_experience
    } do
      {:ok, show_live, _html} = live(conn, ~p"/first_dev_experiences/#{first_dev_experience}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit First dev experience"

      assert_patch(show_live, ~p"/first_dev_experiences/#{first_dev_experience}/show/edit")

      assert show_live
             |> form("#first_dev_experience-form", first_dev_experience: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#first_dev_experience-form", first_dev_experience: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/first_dev_experiences/#{first_dev_experience}")

      html = render(show_live)
      assert html =~ "First dev experience updated successfully"
      assert html =~ "some updated name"
    end
  end
end
