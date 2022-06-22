import lombok.Getter;
import mk.ukim.finki.emt.ordermanagement.domain.valueobjects.ProductId;
import mk.ukim.finki.emt.sharedkernel.domain.base.AbstractEntity;
import mk.ukim.finki.emt.sharedkernel.domain.base.DomainObjectId;
import mk.ukim.finki.emt.sharedkernel.domain.financial.Money;
import org.springframework.lang.NonNull;

import javax.persistence.AttributeOverride;
import javax.persistence.Column;
import javax.persistence.Table;

@Entity
@Table(name="order_item")
@Table(name = "order_item")
@Getter
public class OrderItem extends AbstractEntity<OrderItemId> {

    private Money itemPrice;
    @Column(name = "qty", nullable = false)
    private int quantity;

    @AttributeOverride(name="id", column = @Column(name="product_id", nullable = false))
    @AttributeOverride(name = "id", column = @Column(name = "product_id", nullable = false))
    private ProductId productId;

    private OrderItem() {
        super(DomainObjectId.randomId(OrderItemId.class));
    }

    public OrderItem(@NonNull ProductId productId, @NonNull Money itemPrice, int qty) {
        super(DomainObjectId.randomId(OrderItemId.class));
        this.productId = productId;
        this.itemPrice = itemPrice;
        this.quantity = qty;
    }

    public Money subtotal() {
        return itemPrice.multiply(quantity);
    }
}
import mk.ukim.finki.emt.sharedkernel.domain.base.DomainObjectId;

public class OrderItemId extends DomainObjectId {

    private OrderItemId() {
        super(OrderItemId.randomId(OrderItemId.class).getId());
    }

    public OrderItemId(String uuid) {
        super(uuid);
    }
}
package mk.ukim.finki.emt.ordermanagement.domain.repository;

import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, OrderId> {
}
package mk.ukim.finki.emt.ordermanagement.domain.valueobjects;

import com.fasterxml.jackson.annotation.JsonCreator;
import lombok.Getter;
import mk.ukim.finki.emt.sharedkernel.domain.base.ValueObject;
import mk.ukim.finki.emt.sharedkernel.domain.financial.Currency;
import mk.ukim.finki.emt.sharedkernel.domain.financial.Money;

@Getter
public class Product implements ValueObject {

    private final ProductId id;
    private final String name;
    private final Money price;

    private Product() {
        this.id=ProductId.randomId(ProductId.class);
        this.name= "";
        this.price = Money.valueOf(Currency.MKD,0);
    }

    @JsonCreator
    public Product(ProductId id, String name, Money price) {
        this.id = id;
        this.name = name;
        this.price = price;
    }
}

@Embeddable
public class ProductId extends DomainObjectId {

    private ProductId() {
        super(ProductId.randomId(ProductId.class).getId());
    }

    public ProductId(String uuid) {
        super(uuid);
    }
}
