package business.billing.mapper;

import business.billing.dto.BillDTO;
import business.billing.dto.BillItemDTO;
import business.billing.model.Bill;
import business.billing.model.BillItem;

import java.util.ArrayList;
import java.util.List;

public class BillMapper {

    public static Bill toEntity(BillDTO dto) {
        Bill bill = new Bill();
        bill.setCustomerId(dto.getCustomerId());
        bill.setUserId(dto.getUserId());
        bill.setPaymentMethod(dto.getPaymentMethod());
        bill.setTotalAmount(dto.getTotalAmount());

        List<BillItem> items = new ArrayList<>();
        for (BillItemDTO itemDTO : dto.getItems()) {
            BillItem item = new BillItem();
            item.setBookId(itemDTO.getBookId());
            item.setQuantity(itemDTO.getQuantity());
            item.setPrice(itemDTO.getPrice());
            items.add(item);
        }
        bill.setItems(items);
        return bill;
    }
}
