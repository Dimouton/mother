defmodule FridayProjectWeb.SecondDevExperienceLiveTest do
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

  defp create_second_dev_experience(_) do
    second_dev_experience = second_dev_experience_fixture()
    %{second_dev_experience: second_dev_experience}
  end

  describe "Index" do
    setup [:create_second_dev_experience]

    test "lists all second_dev_experiences", %{
      conn: conn,
      second_dev_experience: second_dev_experience
    } do
      {:ok, _index_live, html} = live(conn, ~p"/second_dev_experiences")

      assert html =~ "Listing Second dev experiences"
      assert html =~ second_dev_experience.name
    end

    test "saves new second_dev_experience", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/second_dev_experiences")

      assert index_live |> element("a", "New Second dev experience") |> render_click() =~
               "New Second dev experience"

      assert_patch(index_live, ~p"/second_dev_experiences/new")

      assert index_live
             |> form("#second_dev_experience-form", second_dev_experience: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#second_dev_experience-form", second_dev_experience: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/second_dev_experiences")

      html = render(index_live)
      assert html =~ "Second dev experience created successfully"
      assert html =~ "some name"
    end

    test "updates second_dev_experience in listing", %{
      conn: conn,
      second_dev_experience: second_dev_experience
    } do
      {:ok, index_live, _html} = live(conn, ~p"/second_dev_experiences")

      assert index_live
             |> element("#second_dev_experiences-#{second_dev_experience.id} a", "Edit")
             |> render_click() =~
               "Edit Second dev experience"

      assert_patch(index_live, ~p"/second_dev_experiences/#{second_dev_experience}/edit")

      assert index_live
             |> form("#second_dev_experience-form", second_dev_experience: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#second_dev_experience-form", second_dev_experience: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/second_dev_experiences")

      html = render(index_live)
      assert html =~ "Second dev experience updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes second_dev_experience in listing", %{
      conn: conn,
      second_dev_experience: second_dev_experience
    } do
      {:ok, index_live, _html} = live(conn, ~p"/second_dev_experiences")

      assert index_live
             |> element("#second_dev_experiences-#{second_dev_experience.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#second_dev_experiences-#{second_dev_experience.id}")
    end
  end

  describe "Show" do
    setup [:create_second_dev_experience]

    test "displays second_dev_experience", %{
      conn: conn,
      second_dev_experience: second_dev_experience
    } do
      {:ok, _show_live, html} = live(conn, ~p"/second_dev_experiences/#{second_dev_experience}")

      assert html =~ "Show Second dev experience"
      assert html =~ second_dev_experience.name
    end

    test "updates second_dev_experience within modal", %{
      conn: conn,
      second_dev_experience: second_dev_experience
    } do
      {:ok, show_live, _html} = live(conn, ~p"/second_dev_experiences/#{second_dev_experience}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Second dev experience"

      assert_patch(show_live, ~p"/second_dev_experiences/#{second_dev_experience}/show/edit")

      assert show_live
             |> form("#second_dev_experience-form", second_dev_experience: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#second_dev_experience-form", second_dev_experience: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/second_dev_experiences/#{second_dev_experience}")

      html = render(show_live)
      assert html =~ "Second dev experience updated successfully"
      assert html =~ "some updated name"
    end
  end
end
