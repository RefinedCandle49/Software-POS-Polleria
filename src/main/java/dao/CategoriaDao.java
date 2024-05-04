package dao;

import model.Categoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static conexion.Conexion.getConnection;

public class CategoriaDao {

    public static List<Categoria> listarCategorias() {
        List<Categoria> listaCategorias = new ArrayList<Categoria>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM categoria");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Categoria cat = new Categoria();
                cat.setIdCategoria(rs.getInt("idCategoria"));
                cat.setNombre(rs.getString("nombre"));
                cat.setDescripcion(rs.getString("descripcion"));
                listaCategorias.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaCategorias;
    }
}
