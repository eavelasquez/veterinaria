//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace VeterinariaApp.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class tbl_servicio
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_servicio()
        {
            this.tbl_factura = new HashSet<tbl_factura>();
        }
    
        public string codigo_s { get; set; }
        public string nombre_s { get; set; }
        public string descripcion_s { get; set; }
        public double precio_s { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_factura> tbl_factura { get; set; }
    }
}
